Return-Path: <liu.yaojin@zte.com.cn>
In-Reply-To: <20100323171321.GA27601@b07421-ec1.am.freescale.net>
To: Scott Wood <scottwood@freescale.com>
Subject: re: Re: The GPIO problem on MPC8323?
MIME-Version: 1.0
Message-ID: <OFC7BFAA92.0DABBDF6-ON482576F0.000B165C-482576F0.000C81FB@zte.com.cn>
From: liu.yaojin@zte.com.cn
Date: Wed, 24 Mar 2010 10:11:38 +0800
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev-bounces+liu.yaojin=zte.com.cn@lists.ozlabs.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

thanks for replying.
it's my first time to use POWERPC,and i found it very different from ARM.
after i select "QE GPIO Suppor" in KConfig, i don't know how to use in 
next step.
Because no device node was found in /dev, and the format of dts is strange 
for me.
could you show me a little example?




On Tue, Mar 23, 2010 at 03:07:49PM +0800, liu.yaojin@zte.com.cn wrote:
> hi,all:
> 
> i saw peter's mpc8xxx_gpio.c in kernel 2.6.31. it seems that file can 
only 
> be used on 831x and others, but not mpc8323. my platform is mpc8323, how 

> can i use the GPIO?
> i also found "QE GPIO Support" and "Support for simple, memory-mapped 
GPIO 
> controllers" selection,  how can i use it and test in user space?
> 
> thanks, best regards.

This is the same e-mail that you sent yesterday...  Yes, you want the QE
GPIO driver for QE chips.  It should work the same as other GPIO drivers. 
Check the documentation or the code for how to use the interface.

-Scott


--------------------------------------------------------
ZTE Information Security Notice: The information contained in this mail is solely property of the sender's organization. This mail communication is confidential. Recipients named above are obligated to maintain secrecy and are not permitted to disclose the contents of this communication to others.
This email and any files transmitted with it are confidential and intended solely for the use of the individual or entity to whom they are addressed. If you have received this email in error please notify the originator of the message. Any views expressed in this message are those of the individual sender.
This message has been scanned for viruses and Spam by ZTE Anti-Spam system.
