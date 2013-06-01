Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C03B42C009C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Jun 2013 14:29:38 +1000 (EST)
Message-ID: <1370060971.3766.11.camel@pasglop>
Subject: Re: [PATCH 18/23] powerpc/eeh: PowerNV EEH backends
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Sat, 01 Jun 2013 14:29:31 +1000
In-Reply-To: <1369902245-5886-19-git-send-email-shangw@linux.vnet.ibm.com>
References: <1369902245-5886-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1369902245-5886-19-git-send-email-shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-05-30 at 16:24 +0800, Gavin Shan wrote:
> The patch adds EEH backends for PowerNV platform. It's notable that
> part of those EEH backends call to the I/O chip dependent backends.

Add a check for my new OPALv3 flag before registering since you rely
on a whole bunch of new APIs that the current versions of OPAL don't
have.

Cheers,
Ben.
