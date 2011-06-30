Return-Path: <mohanreddykv@gmail.com>
MIME-Version: 1.0
Date: Thu, 30 Jun 2011 14:50:47 +0530
Message-ID: <BANLkTikf5bh=jd_7d1yRTUqngTQ2cNpKMQ@mail.gmail.com>
Subject: Problem with a driver in Linux-2.6.33
From: MohanReddy koppula <mohanreddykv@gmail.com>
To: Linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I am writing a device driver for DSP Embedded Line and Port Interface Controller
PEB 20570 (Delic) from infineon. I am using MPC885 custom board. First we wrote
a driver without OS and tested transmission and reception, they are
working fine.

But when I port the same code to the Linux-2.6.33, the chip
initialization is done properly but
transmission and reception are not happening properly. Some times it
receives and transmits the
data but some times it doen't.

Please let me know where could the problem be and how I should
proceed. Is there any open source
driver available for this chip?.

Thanks,
Venkat.
