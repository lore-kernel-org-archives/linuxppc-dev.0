Return-Path: <frannk_m1@yahoo.com>
Received: from web32203.mail.mud.yahoo.com (web32203.mail.mud.yahoo.com
	[68.142.207.134]) by ozlabs.org (Postfix) with SMTP id D7D3FDDEED
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Dec 2006 04:03:48 +1100 (EST)
Date: Wed, 20 Dec 2006 08:57:06 -0800 (PST)
From: Frank <frannk_m1@yahoo.com>
Subject: Re: Define Linux system memory
To: Clint Thomas <cthomas@Soneticom.com>, linuxppc-embedded@ozlabs.org
In-Reply-To: <3C02138692C13C4BB675FE7EA2409529261209@bluefin.Soneticom.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <958023.73009.qm@web32203.mail.mud.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--- Clint Thomas <cthomas@Soneticom.com> wrote:

> To anybody who has done this before or understands how to do
> this, I was
> wondering if you know how to "tell" the kernel how much memory
> there is
> in the system. An example would be if I have 512MB of RAM, but
> only want
> the system to know that there is about 500MB in RAM, so that
> 12MB does
> not exist to the OS/kernel. Would this require mucking about
> in U-boot?
> or can I just define this in the kernel source? Thanks
>  
> Clinton Thomas
On the kernel command line passed by u-boot:
mem=500M

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
