Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Joe Perches <joe@perches.com>
Subject: Re: [TRIVIAL PATCH 11/26] powerpc: Convert print_symbol to %pSR
Date: Thu, 13 Dec 2012 11:58:45 +0000
References: <cover.1355335227.git.joe@perches.com>
 <8c901014a0f571011023ed98b9a22bc690925b73.1355335228.git.joe@perches.com>
In-Reply-To: <8c901014a0f571011023ed98b9a22bc690925b73.1355335228.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201212131158.46055.arnd@arndb.de>
Cc: cbe-oss-dev@lists.ozlabs.org, Jiri Kosina <trivial@kernel.org>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 12 December 2012, Joe Perches wrote:
> Use the new vsprintf extension to avoid any possible
> message interleaving.
> 
> Convert the #ifdef DEBUG block to a single pr_debug.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

nice cleanup!

Acked-by: Arnd Bergmann <arnd@arndb.de>
