Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.232])
	by ozlabs.org (Postfix) with ESMTP id 754E9DDE9F
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Oct 2007 07:55:45 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so2327486nzh
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Sep 2007 14:55:44 -0700 (PDT)
Message-ID: <fa686aa40709301455g1c70be94va34a33d4f49576c@mail.gmail.com>
Date: Sun, 30 Sep 2007 15:55:41 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: linuxppc-dev@ozlabs.org, jwboyer@linux.vnet.ibm.com
Subject: Re: [PATCH 0/3] Bug fixes to Virtex support in arch/ppc
In-Reply-To: <20070930214140.31899.55951.stgit@trillian.cg.shawcable.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070930214140.31899.55951.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 9/30/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> Josh,
>
> Here are some small bug fixes to arch/ppc.  They are all pretty trivial,
> and I think they should go in for 2.6.24.  If there are no problems with
> them, can you please merge them into your tree and ask paulus to pull
> them?

I've also pushed these changes to my git tree:

The following changes since commit c4d5e375470862fd741f93bf0686d7ac2f7fdce4:
  David Gibson (1):
        [POWERPC] Cleanups for physmap_of.c (v2)

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6-virtex.git virtex-for-2.6.24

Grant Likely (3):
      [POWERPC] Uartlite: Flush RX fifo in bootwrapper
      [POWERPC] XilinxFB: Move xilinxfb_platform_data to a shared header file
      [POWERPC] Setup default eth addr in embed_config for Xilinx
Virtex platforms

 arch/ppc/boot/simple/embed_config.c  |    8 ++++++++
 arch/ppc/boot/simple/misc-embedded.c |    4 +++-
 arch/ppc/boot/simple/uartlite_tty.c  |    8 ++++++++
 arch/ppc/syslib/virtex_devices.h     |    8 +-------
 drivers/video/xilinxfb.c             |    2 +-
 include/linux/xilinxfb.h             |   23 +++++++++++++++++++++++
 6 files changed, 44 insertions(+), 9 deletions(-)
 create mode 100644 include/linux/xilinxfb.h

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
