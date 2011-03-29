Return-Path: <matt@ozlabs.org>
Message-ID: <4D9146A6.3020105@ozlabs.org>
Date: Tue, 29 Mar 2011 13:40:38 +1100
From: Matt Evans <matt@ozlabs.org>
MIME-Version: 1.0
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: [PATCH v3 0/4] xhci: Make xHCI driver endian-safe
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


Reposting the whole set, since there're 4 instead of 5 having dropped the 'add
debug' patch in the middle and I thought differing 'vN a/b' subjects may get
confusing otherwise.  (Two of the patches haven't changed. :/ )

These remove the scratty temp variables and comment the return value
of xhci_handle_event().


Cheers,


Matt
