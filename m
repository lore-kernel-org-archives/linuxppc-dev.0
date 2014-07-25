Return-Path: <varkabhadram@gmail.com>
Received: from mail-pd0-x231.google.com (mail-pd0-x231.google.com
 [IPv6:2607:f8b0:400e:c02::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2337F1A0976
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jul 2014 22:06:59 +1000 (EST)
Received: by mail-pd0-f177.google.com with SMTP id p10so5516384pdj.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jul 2014 05:06:56 -0700 (PDT)
Message-ID: <53D24805.9040104@gmail.com>
Date: Fri, 25 Jul 2014 17:35:25 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH v5 2/2] ASoC: fsl_asrc: Add ASRC ASoC CPU DAI and platform
 drivers
References: <cover.1406276436.git.nicoleotsuka@gmail.com>
 <2288e61e600e28448905e32dd4f74a954110248f.1406276436.git.nicoleotsuka@gmail.com>
 <53D240B3.8060203@gmail.com> <20140725112807.GA29852@MrMyself>
In-Reply-To: <20140725112807.GA29852@MrMyself>
Content-Type: multipart/alternative;
 boundary="------------080004070305060206060708"
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, b42378@freescale.com, timur@tabi.org,
 pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, tiwai@suse.de,
 linux-kernel@vger.kernel.org, rdunlap@infradead.org, b02247@freescale.com,
 lgirdwood@gmail.com, robh+dt@kernel.org, perex@perex.cz,
 Nicolin Chen <nicoleotsuka@gmail.com>, broonie@kernel.org,
 galak@codeaurora.org, grant.likely@linaro.org, tklauser@distanz.ch,
 shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------080004070305060206060708
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 07/25/2014 04:58 PM, Nicolin Chen wrote:
> Hi Varka,
>
> On Fri, Jul 25, 2014 at 05:04:11PM +0530, Varka Bhadram wrote:
>> On 07/25/2014 02:16 PM, Nicolin Chen wrote:
>>> The Asynchronous Sample Rate Converter (ASRC) converts the sampling rate of a
>>> signal associated with an input clock into a signal associated with a different
>>> output clock. The driver currently works as a Front End of DPCM with other Back
>>> Ends DAI links such as ESAI<->CS42888 and SSI<->WM8962 and SAI. It converts the
>>> original sample rate to a common rate supported by Back Ends for playback while
>>> converts the common rate of Back Ends to a desired rate for capture. It has 3
>>> pairs to support three different substreams within totally 10 channels.
>>>
>>> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
>>> ---
>>>   .../devicetree/bindings/sound/fsl,asrc.txt         |  60 ++
>>>   sound/soc/fsl/Kconfig                              |   9 +
>>>   sound/soc/fsl/Makefile                             |   2 +
>>>   sound/soc/fsl/fsl_asrc.c                           | 992 +++++++++++++++++++++
>>>   sound/soc/fsl/fsl_asrc.h                           | 461 ++++++++++
>>>   sound/soc/fsl/fsl_asrc_dma.c                       | 386 ++++++++
>>>   6 files changed, 1910 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/sound/fsl,asrc.txt
>>>   create mode 100644 sound/soc/fsl/fsl_asrc.c
>>>   create mode 100644 sound/soc/fsl/fsl_asrc.h
>>>   create mode 100644 sound/soc/fsl/fsl_asrc_dma.c
>>>
>>>
>> check patch warnings on this patch...
> [...]
>
> ./scripts/checkpatch.pl --max-line-length=128 0002-ASoC-fsl_a....patch
> total: 0 errors, 0 warnings, 1928 lines checked
>
> 0002-ASoC....patch has no obvious style problems and is ready for submission
>
> [...]
>
> I think there's no need to be so strict by wrapping all lines inside
> 80 characters, especially for those that will be less readable if being
> wrapped and for those in header file.
>
>
Ohhh .. If this is the case, patch addressed all of comments... Thanks..

/Reviewed-by: Varka Bhadram <varkabhadram@gmail.com>/

-- 
Regards,
Varka Bhadram.


--------------080004070305060206060708
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=windows-1252"
      http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">On 07/25/2014 04:58 PM, Nicolin Chen
      wrote:<br>
    </div>
    <blockquote cite="mid:20140725112807.GA29852@MrMyself" type="cite">
      <pre wrap="">Hi Varka,

On Fri, Jul 25, 2014 at 05:04:11PM +0530, Varka Bhadram wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">On 07/25/2014 02:16 PM, Nicolin Chen wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="">The Asynchronous Sample Rate Converter (ASRC) converts the sampling rate of a
signal associated with an input clock into a signal associated with a different
output clock. The driver currently works as a Front End of DPCM with other Back
Ends DAI links such as ESAI&lt;-&gt;CS42888 and SSI&lt;-&gt;WM8962 and SAI. It converts the
original sample rate to a common rate supported by Back Ends for playback while
converts the common rate of Back Ends to a desired rate for capture. It has 3
pairs to support three different substreams within totally 10 channels.

Signed-off-by: Nicolin Chen <a class="moz-txt-link-rfc2396E" href="mailto:nicoleotsuka@gmail.com">&lt;nicoleotsuka@gmail.com&gt;</a>
---
 .../devicetree/bindings/sound/fsl,asrc.txt         |  60 ++
 sound/soc/fsl/Kconfig                              |   9 +
 sound/soc/fsl/Makefile                             |   2 +
 sound/soc/fsl/fsl_asrc.c                           | 992 +++++++++++++++++++++
 sound/soc/fsl/fsl_asrc.h                           | 461 ++++++++++
 sound/soc/fsl/fsl_asrc_dma.c                       | 386 ++++++++
 6 files changed, 1910 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,asrc.txt
 create mode 100644 sound/soc/fsl/fsl_asrc.c
 create mode 100644 sound/soc/fsl/fsl_asrc.h
 create mode 100644 sound/soc/fsl/fsl_asrc_dma.c


</pre>
        </blockquote>
        <pre wrap="">check patch warnings on this patch...
</pre>
      </blockquote>
      <pre wrap="">
[...]

./scripts/checkpatch.pl --max-line-length=128 0002-ASoC-fsl_a....patch
total: 0 errors, 0 warnings, 1928 lines checked

0002-ASoC....patch has no obvious style problems and is ready for submission

[...]

I think there's no need to be so strict by wrapping all lines inside
80 characters, especially for those that will be less readable if being
wrapped and for those in header file.


</pre>
    </blockquote>
    <pre>Ohhh .. If this is the case, patch addressed all of comments... Thanks..

<span class="st"><em>Reviewed-by: Varka Bhadram <a class="moz-txt-link-rfc2396E" href="mailto:varkabhadram@gmail.com">&lt;varkabhadram@gmail.com&gt;</a></em></span>

</pre>
    <pre class="moz-signature" cols="72">-- 
Regards,
Varka Bhadram.</pre>
  </body>
</html>

--------------080004070305060206060708--
