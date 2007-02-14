Return-Path: <cem.isik@karel.com.tr>
Message-ID: <45D2C9C6.4030307@karel.com.tr>
Date: Wed, 14 Feb 2007 10:35:18 +0200
From: Cem Vedat ISIK <cem.isik@karel.com.tr>
MIME-Version: 1.0
To: Dan Malek <dan@embeddedalley.com>
Subject: Re: Mpc875 Ethernet does not work under linux.
References: <45CAF4C4.7030002@karel.com.tr>
	<50CB27D3-ACF9-47E9-8690-95B76391F18C@embeddedalley.com>
In-Reply-To: <50CB27D3-ACF9-47E9-8690-95B76391F18C@embeddedalley.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	ppc embedded list <linuxppc-embedded@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dan,
As 2.4.25 kernel, I'm using denx-supplied
linuxppc_2_4_devel-2006-04-06-1735 kernel, which shows me "8xx" option
as "Processor Type" in "Platform Support" section with "make menuconfig"
command.
Well, I want to try kernel 2.6.x but, I haven't seen any option for 875
support with "make menuconfig" command. Could you suggest any methods to
configure 2.6 kernel for mpc875?
Thanks in advance, looking forward to hearing from you soon.

Dan Malek wrote:
> 
> On Feb 8, 2007, at 5:00 AM, Cem Vedat ISIK wrote:
> 
>> I'm having a problem using ethernet with denx-provided kernel:
>> linuxppc_2_4_devel-2006-04-06-1735 on mpc875 (a member of mpc885 family).
> 
> Sounds like you didn't properly port your
> kernel.  I use both 2.4 and 2.6 on 875 and 885
> every day.  Works fine.  Take a look at your
> clock routing and PHY support functions to
> ensure that's all correct.
> 
> 
>     -- Dan


-- 
Cem Vedat ISIK
cem.isik@karel.com.tr

PGP Key ID = 0×6D7B02F7
fingerprint = 8C34 144C 999A 917C 8EA0 1199 C136 C114 6D7B 02F7

-----------------------------------------------------------------------
Bu mesaj Karel MailScanner ile tehlikeli icerik ve virus kontrolunden gecirilmistir.
KAREL A.S. - Bilgi Teknolojileri Bolumu
This message has been scanned for viruses and dangerous content by Karel MailScanner, and is believed to be clean.
KAREL A.S. - Information Technologies Department
