Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id E6C4B2C0096
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Feb 2014 07:13:55 +1100 (EST)
Date: Sat, 15 Feb 2014 12:15:15 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Cody P Schafer <cody@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 03/11] sysfs: create bin_attributes under the
 requested group
Message-ID: <20140215201515.GA28316@kroah.com>
References: <1392415338-16288-1-git-send-email-cody@linux.vnet.ibm.com>
 <1392415338-16288-4-git-send-email-cody@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392415338-16288-4-git-send-email-cody@linux.vnet.ibm.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
 LKML <linux-kernel@vger.kernel.org>, Michael Ellerman <michael@ellerman.id.au>,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 14, 2014 at 02:02:07PM -0800, Cody P Schafer wrote:
> bin_attributes created/updated in create_files() (such as those listed
> via (struct device).attribute_groups) were not placed under the
> specified group, and instead appeared in the base kobj directory.
> 
> Fix this by making bin_attributes use creating code similar to normal
> attributes.
> 
> A quick grep shows that no one is using bin_attrs in a named attribute
> group yet, so we can do this without breaking anything in usespace.
> 
> Note that I do not add is_visible() support to
> bin_attributes, though that could be done as well.

is_visible() support would be nice to add if you get a chance.

thanks,

greg k-h
