Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
To: Franz Sirl <Franz.Sirl-ppc@lauterbach.com>
Subject: Re: can/should we use gcc 3.1 to compile kernels
Date: Fri, 7 Jun 2002 17:06:17 -0400
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
References: <20020607201906.GP14252@opus.bloom.county> <5.1.1.2.2.20020607224913.04403008@mail.lauterbach.com>
In-Reply-To: <5.1.1.2.2.20020607224913.04403008@mail.lauterbach.com>
MIME-Version: 1.0
Message-Id: <200206071706.17748.kevin.hendricks@sympatico.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Franz,

Thanks,

BTW under my mailer font (proportional) the remove this part fell right
under the word INFO which confused the hell out of me until I converted it
to a square font and found you wanted me to remove the ##.

:-)

Thanks,

Kevin

On June 7, 2002 04:50, Franz Sirl wrote:
> >Hi,
> >
> >
> >#define CNTRL_REG(INFO,REG) (&(((INFO)->control_regs-> ## REG).r))
>
>                                                         ^^^^
>                                                       superflous
>
> Just remove that and you'll be fine.
>
> Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
