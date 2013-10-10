Return-Path: <paulus@ozlabs.org>
Date: Thu, 10 Oct 2013 21:06:40 +1100
From: Paul Mackerras <paulus@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/3] powerpc/scom: Replace debugfs interface with cleaner
 sysfs one
Message-ID: <20131010100640.GA9906@iris.ozlabs.ibm.com>
References: <1381393115.4330.39.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381393115.4330.39.camel@pasglop>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 10, 2013 at 07:18:35PM +1100, Benjamin Herrenschmidt wrote:
> The debugfs interface was essentially unused, and racy for anything
> other than manual use by a developer. This provides a more useful
> sysfs based one which can be used by programs without racing with
> each other essentially by providing a file to read/write with an
> offset being the scom address << 8.

Don't you mean address << 3 (or address * 8)?

Paul.
