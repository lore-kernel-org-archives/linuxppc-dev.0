Message-ID: <3F5F69F3.4020706@mvista.com>
Date: Wed, 10 Sep 2003 11:14:11 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: Kate Alhola <kate@iti.fi>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC8245 supported in Linux kernel (devel tree from DENX)?
References: <20030910090048.453D9C59E4@atlas.denx.de>
In-Reply-To: <20030910090048.453D9C59E4@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:

>Dear Kate,
>
>in message <3F5EE616.2070305@iti.fi> you wrote:
>
>
>>How about internal PCI bridge support for 8xxx series ? I have tried
>>
>>
>
>Supported and working on several boards.
>
Careful, 824x PCI != 826x/etc. PCI.

>>found it for
>>826x/825x/8270 QUCC-II but it seems that there is just promises around
>>but i have not
>>even found souce of development/alpha version.
>>
>>
>
>You must have missed it. See for example the configurations  for  the
>"ATC" or "PM825" boards (both with MPC8250) in our kernel tree.
>
The 824x uses mpc10x_common code.  The 824x series are NOT PowerQUICC,
they are basically 603e core + MPC107 hostbridge.  For PowerQUICC
embedded processors with a PCI bridge (e.g., 8266), you can look at the
mpc8266ads stuff by Andy Lowe.

This code is in the public linuxppc_2_4_devel tree.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
