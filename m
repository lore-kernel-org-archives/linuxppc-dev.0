Return-Path: <michael@ellerman.id.au>
Date: Mon, 15 Apr 2013 17:36:58 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/8] Nvram-to-pstore
Message-ID: <20130415073657.GD30156@concordia>
References: <20130410071835.20150.56489.stgit@aruna-ThinkPad-T420>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130410071835.20150.56489.stgit@aruna-ThinkPad-T420>
Cc: jkenisto@linux.vnet.ibm.com, mahesh@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
 anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 10, 2013 at 12:50:47PM +0530, Aruna Balakrishnaiah wrote:
> Currently the kernel provides the contents of p-series NVRAM only as a
> simple stream of bytes via /dev/nvram, which must be interpreted in user
> space by the nvram command in the powerpc-utils package.  This patch set
> exploits the pstore subsystem to expose each partition in NVRAM as a
> separate file in /dev/pstore. For instance Oops messages will stored in a
> file named [dmesg-nvram-2].

Please try to fold some of that info into the commit messages for actual
patches. The 0th patch is lost when we commit the series into git.

Also all your patches should have a subject starting with
"powerpc/pseries:".

cheers
