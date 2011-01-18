Return-Path: <anton@samba.org>
Date: Tue, 18 Jan 2011 12:31:52 +1100
From: Anton Blanchard <anton@samba.org>
To: nacc@us.ibm.com
Subject: 2.6.37-git17 virtual IO boot failure
Message-ID: <20110118123152.50f75a72@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I was testing 2.6.37-git17 on a POWER7 with virtual IO and hit this:

Trying to unpack rootfs image as initramfs...
Freeing initrd memory: 7446k freed
vio 30000000: Warning: IOMMU dma not supported: mask
0xffffffffffffffff, table unavailable
vio 4000: Warning: IOMMU dma not supported: mask 0xffffffffffffffff,
table unavailable
vio 4001: Warning: IOMMU dma not supported: mask 0xffffffffffffffff,
table unavailable
vio 4002: Warning: IOMMU dma not supported: mask 0xffffffffffffffff,
table unavailable
vio 4004: Warning: IOMMU dma not supported: mask 0xffffffffffffffff,
table unavailable
audit: initializing netlink socket (disabled)

Haven't had a chance to look closer yet.

Anton
