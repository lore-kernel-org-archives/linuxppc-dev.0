Return-Path: <jonsmirl@gmail.com>
MIME-Version: 1.0
Date: Sat, 24 Jan 2009 20:20:46 -0500
Message-ID: <9e4733910901241720j157b7946t58792a9b2b21f1a3@mail.gmail.com>
Subject: mpc5200 and PWM
From: Jon Smirl <jonsmirl@gmail.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Is it possible to use Bestcomm with PWM to generate complex waveforms?
For example change the frequency and duty cycle after each cycle? Has
anyone tried doing this? I'd like to build a table of count/width
pairs and then feed them to the PWM pin without taking an interrupt on
each cycle.

-- 
Jon Smirl
jonsmirl@gmail.com
