Message-ID: <40D41B9D.80201@246tNt.com>
Date: Sat, 19 Jun 2004 12:55:25 +0200
From: Sylvain Munaut <tnt@246tnt.com>
MIME-Version: 1.0
To: Dale Farnsworth <dale@farnsworth.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH][RFC] MPC52xx basic support on linux 2.6 (was DMA support
 for MPC5xxx?)
References: <20040603090635.B7347@home.com> <20040603164245.B24A9C109F@atlas.denx.de> <20040603113302.A24468@home.com> <20040603185053.GN15195@smtp.west.cox.net> <40BF87BB.4020808@246tNt.com> <20040603134804.B24468@home.com> <40C8BB6C.4040709@246tNt.com> <20040618192046.GA22607@zenos.farnsworth.org>
In-Reply-To: <20040618192046.GA22607@zenos.farnsworth.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dale Farnsworth wrote:

>On Thu, Jun 10, 2004 at 07:50:04PM +0000, Sylvain Munaut wrote:
>
>
>>Here it is, slightly delayed because of hardrive crash and need to
>>rename all 'Motorola' to 'Freescale' ;)
>>
>>It's there :
>>
>>http://www.246tNt.com/linux-2.5-mpc52xx-pending-20040610.diff
>>bk://bkbits.246tNt.com/linux-2.5-mpc52xx-pending
>>
>>
>
>FWIW, I'd like to see the above go into linux-2.5.
>
>I found a few issues.
>  - need to call uart_update_timeout
>  - Maximum delay for console_write (printk) was too short
>  - one missed icecube to lite5200 name change.
>
>This patch applies on top Sylvain's patch above.
>
>
Thanks,

Merged with others bits I fixed.
Already in the -devel tree. I'll push it to the others as soon as I
figure how to do it with bitkeeper ;) ...


Sylvain Munaut

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
