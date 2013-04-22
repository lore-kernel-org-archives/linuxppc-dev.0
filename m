Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH 0/5] of_platform_driver and OF_DEVICE removal
Date: Mon, 22 Apr 2013 09:03:54 +0200
References: <1366596798-9457-1-git-send-email-robherring2@gmail.com>
In-Reply-To: <1366596798-9457-1-git-send-email-robherring2@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201304220903.54788.arnd@arndb.de>
Cc: Roland Dreier <roland@kernel.org>, Sean Hefty <sean.hefty@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 devicetree-discuss@lists.ozlabs.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>,
 linux-rdma@vger.kernel.org, Christoph Raisch <raisch@de.ibm.com>,
 Hoang-Nam Nguyen <hnguyen@de.ibm.com>,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Grant Likely <grant.likely@linaro.org>, Paul Mackerras <paulus@samba.org>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Hal Rosenstock <hal.rosenstock@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 22 April 2013, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> This series is a relatively straight-forward removal of the last remaining
> user of of_platform_driver (ibmebus) and removal of CONFIG_OF_DEVICE which
> is always enabled when CONFIG_OF is enabled.
> 
> Compile tested on powerpc and sparc.
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
