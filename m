Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: kou.ishizaki@toshiba.co.jp
Subject: Re: [Cbe-oss-dev] [patch 1/5] spu_manage: use newer physical-id
Date: Thu, 23 Aug 2007 18:12:19 +0200
References: <20070823.180152.-1300528381.kouish@swc.toshiba.co.jp>
In-Reply-To: <20070823.180152.-1300528381.kouish@swc.toshiba.co.jp>
MIME-Version: 1.0
Message-Id: <200708231812.20493.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-15"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
	cbe-oss-dev@ozlabs.org, jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 23 August 2007, kou.ishizaki@toshiba.co.jp wrote:
> Please check "unit-id" if "physical-id" doesn't exist. Because Celleb
> uses "unit-id" to provide spe_id.

Ok, I need to discuss this with Christian then, to make sure we get to
a version that works everywhere. Paul, please ignore this patch for now.

I've update the git repository to only have the other four patches.

	Arnd <><
