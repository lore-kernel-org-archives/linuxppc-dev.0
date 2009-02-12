Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 48998DDDBA
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 19:07:20 +1100 (EST)
To: "Shubhada Pugaonkar" <shubhada@chelsio.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: AMCC ppc440spe 2.6.23.10 kernel boot help
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <8A71B368A89016469F72CD08050AD33402D57545@maui.asicdesigners.com>
References: <8A71B368A89016469F72CD08050AD33402D57545@maui.asicdesigners.com>
Date: Thu, 12 Feb 2009 09:07:16 +0100
Message-Id: <20090212080716.4DE0D832E893@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Shubhada,

In message <8A71B368A89016469F72CD08050AD33402D57545@maui.asicdesigners.com> you wrote:
> 
> I am kind of helpless regarding the kernel version, as our customer is
> using it and I need to replicate their environment. I just tried 2.6.28
> with katmai_defconfig file and still face the same problem. 

You probably did not load (and use) the device tree blob which is
needed with recent (arch/powerpc based) kernel versions.

> The config file that I sent before is provided by the customer. It is a
> working configuration for them. 
> 
> The exact board that I have is Katmai.

It looks broken to me for a Katmai board. Are you sure your customer
is also using Katmai?

> my printenv output is as follows.

This is obviously  an  old  setup  for  old  (arch/ppc  only)  kernel
versions,  and  heavily  crippl^H^H^H^H^H  modified  from the default
environment.  You  might  consider  to  restart  from   the   default
environment settings (probably even with a recent version of U-Boot -
your's is too old and does not include full device tree support).

On the other hand, I don;t see a reason why the old (arch/ppc based)
kernel should not boot - except that it might be misconfigured for
that board.

Did you try any of the released (and well tested) kernel images on
our FTP server? See ftp://ftp.denx.de/pub/linux/images/amcc/katmai/

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Just think of a computer as hardware you can program."
- Nigel de la Tierre
