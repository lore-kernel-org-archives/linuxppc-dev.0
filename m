Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910801181356o57a6f49sabcf842375a9a802@mail.gmail.com>
Date: Fri, 18 Jan 2008 16:56:23 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Linux/PPC Development" <Linuxppc-dev@ozlabs.org>
Subject: External audio clock with MPC5200B
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Has anyone tried using an external audio clock chip with the MPC5200B?
We've discovered that the on-chip clock dividers aren't flexible
enough and have too much error in the final frequencies. The level of
error is ok for iPod type use but not for playing broadcast music.
192K sample rate is totally messed up with a 2.7% error.

Note to chip designers - USB and 44.1Khz are not compatible
frequencies and can't share the same PLL without FractionalN dividers
on the audio clock. Freescale MX31/MX21 both have separate PLLs for
UBS and audio.

-- 
Jon Smirl
jonsmirl@gmail.com
