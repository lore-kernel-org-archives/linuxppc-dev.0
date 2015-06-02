Return-Path: <neelegup@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F24741A0065
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 15:14:55 +1000 (AEST)
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4FD041412E9
 for <linuxppc-dev@ozlabs.org>; Tue,  2 Jun 2015 15:14:55 +1000 (AEST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <neelegup@linux.vnet.ibm.com>;
 Tue, 2 Jun 2015 10:44:53 +0530
Message-ID: <556D3BC6.6010207@linux.vnet.ibm.com>
Date: Tue, 02 Jun 2015 10:44:46 +0530
From: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@ozlabs.org,
 computersforpeace@gmail.com
CC: linux-mtd@lists.infradead.org, Joel Stanley <joel@jms.id.au>,
 Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH V3] drivers/mtd: add powernv flash MTD abstraction driver
References: <1433219169-5115-1-git-send-email-cyrilbur@gmail.com>
In-Reply-To: <1433219169-5115-1-git-send-email-cyrilbur@gmail.com>
Content-Type: multipart/alternative;
 boundary="------------030603070204020608010006"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030603070204020608010006
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/02/2015 09:56 AM, Cyril Bur wrote:
> Powerpc powernv platforms allow access to certain system flash devices
> through a firmwarwe interface. This change adds an mtd driver for these
> flash devices.
>
> Minor updates from Jeremy Kerr and Joel Stanley.
>
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

Reviewed-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>

Neelesh.

> ---
> Hello Brian and MTD folk,
> Could I please get an ACK for Michael to take this through the powerpc
> tree.
> Thanks.
>
>
> V2: Address Brian Norris' review
>      Fix typos
>      Change from NAND flash type to NOR flash type
>      Correctness tweaks
> V3: Address Neelesh Gupta's review
>      Minor corrections
>      Release the opal token on error
>      Unregister mtd device on module remove
> ---
>   drivers/mtd/devices/Kconfig         |   8 +
>   drivers/mtd/devices/Makefile        |   1 +
>   drivers/mtd/devices/powernv_flash.c | 286 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 295 insertions(+)
>   create mode 100644 drivers/mtd/devices/powernv_flash.c
>
>


--------------030603070204020608010006
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <br>
    <br>
    <div class="moz-cite-prefix">On 06/02/2015 09:56 AM, Cyril Bur
      wrote:<br>
    </div>
    <blockquote
      cite="mid:1433219169-5115-1-git-send-email-cyrilbur@gmail.com"
      type="cite">
      <pre wrap="">Powerpc powernv platforms allow access to certain system flash devices
through a firmwarwe interface. This change adds an mtd driver for these
flash devices.

Minor updates from Jeremy Kerr and Joel Stanley.

Signed-off-by: Cyril Bur <a class="moz-txt-link-rfc2396E" href="mailto:cyrilbur@gmail.com">&lt;cyrilbur@gmail.com&gt;</a>
Signed-off-by: Joel Stanley <a class="moz-txt-link-rfc2396E" href="mailto:joel@jms.id.au">&lt;joel@jms.id.au&gt;</a>
Signed-off-by: Jeremy Kerr <a class="moz-txt-link-rfc2396E" href="mailto:jk@ozlabs.org">&lt;jk@ozlabs.org&gt;</a></pre>
    </blockquote>
    <br>
    <small>Reviewed-by: Neelesh Gupta
      <a class="moz-txt-link-rfc2396E" href="mailto:neelegup@linux.vnet.ibm.com">&lt;neelegup@linux.vnet.ibm.com&gt;</a><br>
      <br>
      Neelesh.<br>
    </small><br>
    <blockquote
      cite="mid:1433219169-5115-1-git-send-email-cyrilbur@gmail.com"
      type="cite">
      <pre wrap="">
---
Hello Brian and MTD folk,
Could I please get an ACK for Michael to take this through the powerpc
tree.
Thanks.


V2: Address Brian Norris' review
    Fix typos
    Change from NAND flash type to NOR flash type
    Correctness tweaks
V3: Address Neelesh Gupta's review
    Minor corrections
    Release the opal token on error
    Unregister mtd device on module remove
---
 drivers/mtd/devices/Kconfig         |   8 +
 drivers/mtd/devices/Makefile        |   1 +
 drivers/mtd/devices/powernv_flash.c | 286 ++++++++++++++++++++++++++++++++++++
 3 files changed, 295 insertions(+)
 create mode 100644 drivers/mtd/devices/powernv_flash.c


</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------030603070204020608010006--
