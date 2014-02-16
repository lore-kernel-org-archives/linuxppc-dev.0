Return-Path: <paul.gortmaker@gmail.com>
Received: from mail-wi0-x22f.google.com (mail-wi0-x22f.google.com
 [IPv6:2a00:1450:400c:c05::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 55F5C2C009F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Feb 2014 02:57:01 +1100 (EST)
Received: by mail-wi0-f175.google.com with SMTP id hm4so1694880wib.14
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Feb 2014 07:56:55 -0800 (PST)
MIME-Version: 1.0
Sender: paul.gortmaker@gmail.com
In-Reply-To: <CAGtOQbTRSk32p7U=v9V9GPb_ro+WYbKLLCCfrmdypePcHA++mw@mail.gmail.com>
References: <CAGtOQbTRSk32p7U=v9V9GPb_ro+WYbKLLCCfrmdypePcHA++mw@mail.gmail.com>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Sun, 16 Feb 2014 10:56:24 -0500
Message-ID: <CAP=VYLpgMYaSVjTwJ2Q15XB+nozz=OhAPU85Nb9xG_FdP5dcyA@mail.gmail.com>
Subject: Re: Anyone using SysRQ key sequences on console serial port ?
To: John Donnelly <john.d@servergy.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 14, 2014 at 3:42 PM, John Donnelly <john.d@servergy.com> wrote:
> Hi,
>
>  I tried using the SysRq hotkey sequence on a serial console -
> 3.11.0-5-powerpc-e500mc system, by issuing a " break " and the system
> immediately wedges after displaying "SysRQ : HELP : " using both "Putty" and
> "Teraterm"  terminal emulators. I know the system is dead because my ssh
> sessions stopped too.

Yes it does work -- or at least it _did_ work.  Make sure your dts has an entry

                        compatible = "fsl,ns16550", "ns16550";

since that enables a workaround I'd added for a hardware errata relating
to sending breaks over the serial console.   What you describe above
makes me think you aren't getting the workaround enabled.

Paul.
--

>
> http://en.wikipedia.org/wiki/Magic_SysRq_key .
>
>
>
>
> --
>
> Regards,
>  John.
>
> --
>
> o Energy-efficiency is #1 reason data centers look to expand.  -- Digital
> Realty Trust
> o Green Data Centers spending to increase 300% worldwide by 2016.  -- Pike
> Research
> o Data Centers have become as vital to the functioni
> ng of society as power stations.  -- The Economist
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
