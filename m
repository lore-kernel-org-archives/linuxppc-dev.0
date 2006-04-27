Return-Path: <penberg@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.206])
	by ozlabs.org (Postfix) with ESMTP id 68C89679F7
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 23:49:42 +1000 (EST)
Received: by nz-out-0102.google.com with SMTP id l8so1719718nzf
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 06:49:41 -0700 (PDT)
Message-ID: <84144f020604270642j788be2ecp82841ac3b3ebcaad@mail.gmail.com>
Date: Thu, 27 Apr 2006 16:42:52 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
Sender: penberg@gmail.com
To: "=?ISO-8859-1?Q?J=F6rn_Engel?=" <joern@wohnheim.fh-wedel.de>
Subject: Re: [PATCH 13/16] ehca: firmware InfiniBand interface
In-Reply-To: <20060427123701.GG32127@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4450A1C0.3080209@de.ibm.com>
	<20060427123701.GG32127@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	linuxppc-dev@ozlabs.org, Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 4/27/06, J=F6rn Engel <joern@wohnheim.fh-wedel.de> wrote:
> The whole patch is full of parameter-happy functions with this one
> being the ugly top of the iceberg.  I sincerely hope this is not a
> defined ABI and can still be changed.

It's not in mainline, so it can be changed.

                                                Pekka
