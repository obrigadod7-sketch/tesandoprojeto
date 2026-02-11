import heroImage from "@/assets/hero-oficial-2-1.png";
import pastoralImage from "@/assets/familia-pastoral.png";
import bgCultos from "@/assets/bg-cultos-ao-vivo-real.jpg";
import bgCelulas from "@/assets/bg-celulas-nas-casas-real.jpg";
import paperTexture from "@/assets/texture-paper.png";
import { ElementorHeader } from "@/components/site/ElementorHeader";

const Index = () => {
  return (
    <div className="min-h-screen bg-background text-foreground">
      {/* Header sobre o hero (como Elementor) */}
      <ElementorHeader />

      <main className="pt-[92px] md:pt-0">
        {/* HERO (imagem + overlay) */}
        <section aria-label="Hero" className="relative -my-[21px] min-h-[460px] w-full overflow-hidden md:min-h-[775px]">
          <img
            src={heroImage}
            alt="Banner da Missão Evangélica Lusitana"
            className="absolute inset-0 h-full w-full object-cover"
            loading="eager"
          />
          <div aria-hidden className="absolute inset-0 bg-gradient-to-b from-mel-overlay/60 to-mel-overlay/60" />

          {/* Espaçador como no Elementor */}
          <div className="relative px-6 py-24 sm:px-10 sm:py-28 md:px-[276px] md:py-[276px] max-[980px]:px-[113px] max-[980px]:py-[113px]" />
        </section>

        {/* Bloco (desktop) - Estudo bíblico + Oração (como Elementor) */}
        <section aria-label="Estudo bíblico e oração (desktop)" className="hidden bg-mel-blue800 md:block">
          <div className="mx-auto w-full max-w-[1155px] px-6 py-6">
            <div className="grid grid-cols-2 gap-0">
              {/* Estudo */}
              <div className="text-center">
                <h2 className="font-display text-[26px] font-semibold uppercase leading-tight text-primary-foreground">
                  PARTICIPE DO ESTUDO <br /> BIBLICO
                </h2>
                <div className="mt-4 flex justify-center">
                  <a
                    className="inline-flex h-12 w-full max-w-[520px] items-center justify-center bg-mel-blue700 px-6 font-display text-[12px] font-semibold uppercase tracking-[0.35em] text-primary-foreground"
                    href="https://missionevangeliquelusitana.com/reunioes-pelo-zoom/"
                  >
                    Estudo biblico
                  </a>
                </div>
              </div>

              {/* Oração */}
              <div className="text-center">
                <h2 className="font-display text-[26px] font-semibold uppercase leading-tight text-primary-foreground">
                  PECA SUA <br /> ORACAO
                </h2>
                <div className="mt-4 flex justify-center">
                  <a
                    className="inline-flex h-12 w-full max-w-[520px] items-center justify-center bg-mel-blue700 px-6 font-display text-[12px] font-semibold uppercase tracking-[0.35em] text-primary-foreground"
                    href="https://missionevangeliquelusitana.com/pedidos-de-oracao/"
                  >
                    PECA SUA ORACAO
                  </a>
                </div>
              </div>
            </div>
          </div>
        </section>

        {/* Bloco (mobile only) - Estudo Bíblico stretched com gradiente e animação */}
        <section
          aria-label="Estudo bíblico (mobile)"
          id="estudo"
          className="relative w-full overflow-hidden bg-mel-blue800 md:hidden"
        >
          <div aria-hidden className="absolute inset-0 bg-gradient-to-b from-transparent to-mel-overlay/20" />
          
          <div className="relative">
            <div className="bg-gradient-to-b from-mel-blue600 to-mel-blue800 px-[25px] py-[35px]">
              <h2 className="animate-fade-in text-center font-display text-[25px] font-semibold uppercase leading-tight text-primary-foreground">
                PARTICIPE DO <br /> ESTUDO BIBLICO
              </h2>
              <div className="mt-6 flex justify-center">
                <a
                  className="inline-flex h-12 w-full items-center justify-center bg-mel-blue700 px-6 font-display text-[12px] font-semibold uppercase tracking-[0.35em] text-primary-foreground"
                  href="https://missionevangeliquelusitana.com/reunioes-pelo-zoom/"
                >
                  Estudo Biblico
                </a>
              </div>
            </div>
          </div>
        </section>


        {/* 2 cards (Cultos ao vivo / Células) */}
        <section aria-label="Cultos e células" className="bg-gradient-to-br from-mel-blueA to-mel-blueB p-px">
          <div className="grid w-full md:grid-cols-2">
            {/* Coluna 1 */}
            <div className="relative overflow-hidden">
              {/* imagem (propositalmente mais suave/desbotada) */}
              <img
                src={bgCultos}
                alt="Cultos ao vivo"
                loading="lazy"
                decoding="async"
                className="absolute inset-0 h-full w-full object-cover object-center blur-[3px] saturate-85 contrast-85 brightness-90"
              />

              {/* textura (papel/canvas) */}
              <div
                aria-hidden
                className="absolute inset-0 opacity-25 mix-blend-soft-light"
                style={{ backgroundImage: `url(${paperTexture})`, backgroundRepeat: "repeat" }}
              />
              {/* haze azul + escurecimento para esconder a foto e destacar o texto */}
              <div aria-hidden className="absolute inset-0 bg-mel-haze/28" />
              <div aria-hidden className="absolute inset-0 bg-gradient-to-b from-mel-overlay/25 via-mel-haze/28 to-mel-overlay/60" />

              <div className="relative flex min-h-[340px] flex-col items-center justify-center px-10 text-center md:min-h-[400px]">
                <h2 className="font-display text-[34px] font-semibold uppercase tracking-[0.14em] text-primary-foreground drop-shadow-md animate-fade-in">
                  <a href="https://missionevangeliquelusitana.com/pagina-das-reunioes-online/">CULTOS AO VIVO</a>
                </h2>

                <div className="h-14" aria-hidden />

                <a
                  className="inline-flex h-[54px] min-w-[240px] items-center justify-center rounded-md bg-card/75 px-12 font-display text-[11px] font-semibold uppercase tracking-[0.45em] text-foreground shadow-elev ring-1 ring-border backdrop-blur-md"
                  href="https://missionevangeliquelusitana.com/pagina-das-reunioes-online/"
                >
                  INFORMACOES
                </a>
              </div>
            </div>

            {/* Coluna 2 */}
            <div className="relative overflow-hidden">
              {/* imagem (propositalmente mais suave/desbotada) */}
              <img
                src={bgCelulas}
                alt="Células nas casas"
                loading="lazy"
                decoding="async"
                className="absolute inset-0 h-full w-full object-cover object-center blur-[3px] saturate-85 contrast-85 brightness-90"
              />

              {/* textura (papel/canvas) */}
              <div
                aria-hidden
                className="absolute inset-0 opacity-25 mix-blend-soft-light"
                style={{ backgroundImage: `url(${paperTexture})`, backgroundRepeat: "repeat" }}
              />
              {/* haze azul + escurecimento para esconder a foto e destacar o texto */}
              <div aria-hidden className="absolute inset-0 bg-mel-haze/28" />
              <div aria-hidden className="absolute inset-0 bg-gradient-to-b from-mel-overlay/25 via-mel-haze/28 to-mel-overlay/60" />

              <div className="relative flex min-h-[340px] flex-col items-center justify-center px-10 text-center md:min-h-[400px]">
                <h2 className="font-display text-[34px] font-semibold uppercase tracking-[0.14em] text-primary-foreground drop-shadow-md animate-fade-in">
                  <a href="https://missionevangeliquelusitana.com/celular-nas-casas/">CELULAS NAS CASAS</a>
                </h2>

                <div className="h-14" aria-hidden />

                <a
                  className="inline-flex h-[54px] min-w-[240px] items-center justify-center rounded-md bg-card/75 px-12 font-display text-[11px] font-semibold uppercase tracking-[0.45em] text-foreground shadow-elev ring-1 ring-border backdrop-blur-md"
                  href="https://missionevangeliquelusitana.com/celular-nas-casas/"
                >
                  INFORMACOES
                </a>
              </div>
            </div>
          </div>
        </section>

        {/* Família pastoral */}
        <section id="pastoral" aria-label="Família pastoral" className="bg-card p-px">
          <div className="container py-10 text-center">
            <h2 className="font-display text-[2.2em] text-mel-blue800">Familia pastoral.</h2>
            <img
              src={pastoralImage}
              alt="Família pastoral"
              loading="lazy"
              className="mx-auto mt-6 w-[30%] max-w-[420px] max-[980px]:w-[70%]"
            />
          </div>
        </section>
      </main>
    </div>
  );
};

export default Index;
