Message-ID: <3BBDD42E.489D8EC7@staubli.com>
Date: Fri, 05 Oct 2001 17:39:26 +0200
From: Pierre AUBERT <p.aubert@staubli.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: Mailing list Embedded linux on PowerPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: xconfig
References: <3BBD9FC3.3F742EF6@staubli.com> <20011005080512.C4379@cpe-24-221-152-185.az.sprintbbd.net>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:

> On Fri, Oct 05, 2001 at 01:55:48PM +0200, Pierre AUBERT wrote:
>
> > I have a problem with the 'make xconfig'. I try to use it on a 2.4.10
> > kernel for power PC, I have the following
> > error messages when I save the config file :
> > ERROR - Attempting to write value for unconfigured variable
> > (CONFIG_SCC_ENET).
> > ERROR - Attempting to write value for unconfigured variable
> > (CONFIG_FEC_ENET).
>
> Yeap.  Try the following patch.  It is old, I just looked and it won't
> apply cleanly, but it should give you an idea how the right fix should
> look.  If you can make this patch apply to the current tree and send it
> back to me I'd appreciate it.
> still.

Your patch solves my problem (even if some line numbers are false, it works
except for arch/ppc/8xx_io/Config.in but I don't understand why it fails).
Thank you very much. I think it would be included in a future release ...
Regards

--
------------------------------------------------------------------------------
Pierre Aubert                   |   Phone:  +33 4 50 65 62 88
                                |   Fax:    +33 4 50 65 62 08
STÄUBLI Faverges                |
Place Robert STÄUBLI            |   Mailto:p.aubert@staubli.com
74210 Faverges FRANCE           |   http://www.staubli.com
------------------------------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
