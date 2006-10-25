Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 11/16] sysfs: add support for adding/removing spu sysfs
	attributes
Date: Wed, 25 Oct 2006 14:27:18 +0200
References: <20061024163113.694643000@arndb.de>
	<20061024163816.460479000@arndb.de>
	<20061025075238.GA7090@osiris.boeblingen.de.ibm.com>
In-Reply-To: <20061025075238.GA7090@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200610251427.20039.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, cbe-oss-dev@ozlabs.org,
	Christian Krafft <krafft@de.ibm.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 25 October 2006 09:52, Heiko Carstens wrote:
> You probably should check for errors on sysdev_create_file, clean up and
> return an error number instead of always 0.
> This is true for all the new functions here.

Right, thanks for the review.

Christian or I will take care of this.

	Arnd <><
