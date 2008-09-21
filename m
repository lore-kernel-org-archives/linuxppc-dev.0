Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910809211353k1f06fb5bi219c124d0c44b47a@mail.gmail.com>
Date: Sun, 21 Sep 2008 16:53:24 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: solution to printk() blocking interrupts?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Does anyone have a solution to the problem of printk() to a serial
console blocking interrupts for too long? I'm losing interrupts I need
because my hardware is getting overrun.

-- 
Jon Smirl
jonsmirl@gmail.com
