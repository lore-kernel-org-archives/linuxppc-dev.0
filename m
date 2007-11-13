Return-Path: <benh@kernel.crashing.org>
Subject: Re: printk/console_init
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Siva Prasad <sprasad@bivio.net>
In-Reply-To: <D83235F0F3C86D4D889D8B9A0DA8C6D7F73BF1@corpexc01.corp.networkrobots.com>
References: <D83235F0F3C86D4D889D8B9A0DA8C6D7F73BF1@corpexc01.corp.networkrobots.com>
Content-Type: text/plain
Date: Tue, 13 Nov 2007 21:01:47 +1100
Message-Id: <1194948107.18185.101.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2007-11-12 at 18:54 -0800, Siva Prasad wrote:
> Hi,
> 
> I am using 2.6.19 Linux on 8641D based system.
> 
> I am using early printk's and it works fine until console_init() is
> executed. After that it does not, as the early printk's get disabled,
> which is fine. However, I don't see any prints after that at all, that
> are based on regular printk statements. I looked directly into the
> memory at __log_buf and found all the print messages. It is just not
> coming out to the serial port properly.
> 
> It would be great if some one can tell me various parameters that I need
> to consider changing, to successfully port the serial driver for a new
> board.
> 
> Based on the early printk's, I am getting the following messages...

You can use udbg-immortal to force the udbg early printk to stay around,
and then use printk to see what's going on with your serial driver.

Ben.
