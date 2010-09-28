Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id A8DFAB7153
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Sep 2010 22:45:47 +1000 (EST)
Message-ID: <4CA1E36A.2000005@redhat.com>
Date: Tue, 28 Sep 2010 14:45:30 +0200
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 8/8] v2 Update memory hotplug documentation
References: <4CA0EBEB.1030204@austin.ibm.com> <4CA0F076.1070803@austin.ibm.com>
In-Reply-To: <4CA0F076.1070803@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave@linux.vnet.ibm.com>, linux-mm@kvack.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  On 09/27/2010 09:28 PM, Nathan Fontenot wrote:
>
>   For example, assume 1GiB section size. A device for a memory starting at
>   0x100000000 is /sys/device/system/memory/memory4
>   (0x100000000 / 1Gib = 4)
>   This device covers address range [0x100000000 ... 0x140000000)
>
> -Under each section, you can see 4 files.
> +Under each section, you can see 5 files.

Shouldn't this be, 4 or 5 files depending on kernel version?

-- 
error compiling committee.c: too many arguments to function
