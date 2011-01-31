Return-Path: <jwboyer@linux.vnet.ibm.com>
Date: Mon, 31 Jan 2011 06:24:00 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/3 RFC] dt: add documentation of ARM dt boot interface
Message-ID: <20110131112400.GB13541@zod.rchland.ibm.com>
References: <20110131073918.9058.37628.stgit@localhost6.localdomain6>
	<20110131074510.9058.59071.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110131074510.9058.59071.stgit@localhost6.localdomain6>
Cc: sam@ravnborg.org, devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 31, 2011 at 12:45:41AM -0700, Grant Likely wrote:
>Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>---
>
>For RFC only.  I do not plan to merge this change yet.
>
>g.
>
> Documentation/devicetree/booting-without-of.txt |   40 +++++++++++++++++++++++
> 1 files changed, 40 insertions(+), 0 deletions(-)
>
>diff --git a/Documentation/devicetree/booting-without-of.txt b/Documentation/devicetree/booting-without-of.txt
>index 6bca668..3950aea 100644
>--- a/Documentation/devicetree/booting-without-of.txt
>+++ b/Documentation/devicetree/booting-without-of.txt
>@@ -232,6 +233,45 @@ it with special cases.
>   cannot support both configurations with Book E and configurations
>   with classic Powerpc architectures.
>
>+2) Entry point for arch/arm
>+---------------------------
>+
>+   There is one and one single entry point to the kernel, at the start

"one and one" ?

josh
