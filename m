Content-Type: text/plain;
  charset="iso-8859-1"
From: Ricardo Scop <scop@digitel.com.br>
To: "Qsyang" <yangqs@163.com>,
	"linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: close to porting success.....
Date: Fri, 12 Dec 2003 20:50:54 -0200
References: <200312120632.AAA23173@lists.linuxppc.org>
In-Reply-To: <200312120632.AAA23173@lists.linuxppc.org>
MIME-Version: 1.0
Message-Id: <200312122050.54421.scop@digitel.com.br>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Qsyang:

On Friday 12 December 2003 04:36, Qsyang wrote:
> dear all,
>  I am porting U-boot-1.0.0 to my custom MPC8xx board and success is
> being expectted coming soon(maybe too conceited^&^). Now i have a
> question which describes below.
>     So far it is working fine when i am using BDI2000 and runing 'BDI>go
> 0x02800100' in Telnet console,and then all the U-boot commands are
> working very well.
>  But when i disconnected BDI and power on board directly ,U-Boot
> crasheed after relocation to RAM. FAQ say that SDRAM initialization is
> bad ,if this is the case why it is OK when using BDI to boot it. What's
> the difference between the two conditions? Maybe some hardware problem?

Maybe there's some SDRAM controller initialization in BDI2000 configuration
file that's missing in your U-boot code. You should check this first.

Have fun,

-Scop.

>
> 	Any help would be highly appreciated !
>
>
> Qsyang
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
