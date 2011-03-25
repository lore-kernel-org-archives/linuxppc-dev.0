Return-Path: <matt@ozlabs.org>
Message-ID: <4D8C47B0.1050104@ozlabs.org>
Date: Fri, 25 Mar 2011 18:43:44 +1100
From: Matt Evans <matt@ozlabs.org>
MIME-Version: 1.0
To: sarah.a.sharp@linux.intel.com
Subject: [PATCH 0/5] Make xHCI driver endian-safe, add a barrier, some debug
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Sarah,


This series addresses the endian issues with the xHCI driver, and has brought
lovely USB 3 to PPC. :-)  I've tested various types of traffic on ppc4xx and
POWER7 and (some sound driver bugs notwithstanding) all seems fine.  Also
addresses an ordering problem we found and the recursive nature of the event
handling, plus the addition of some debug.

This should apply to 2.6.38/Linus' tree.


Thanks!


Matt
