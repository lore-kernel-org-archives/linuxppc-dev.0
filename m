Return-Path: <zhonglei@RCS-9000.COM>
Date: Sun,  4 Sep 2005 13:06:40 +0800
Message-Id: <200509041306.AA12386382@RCS-9000.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "zhonglei" <zhonglei@RCS-9000.COM>
To: <Linuxppc-dev@ozlabs.org>
Subject: BestComm in MPC5200
Reply-To: zhonglei@RCS-9000.COM
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

hi:
 I use BestComm API in my driver. I include all the needed .h file in my driver and succeed in compiling the module. But when I insmod and the
program runs to the function TaskLoadImage((sdma_regs*)MPC52xxx_SDMA), the Nfs from host to target board is disconnected!What's the problem?
Thanks
zhonglei
