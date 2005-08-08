Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17143.61284.499588.465260@cargo.ozlabs.ibm.com>
Date: Tue, 9 Aug 2005 09:48:52 +1000
From: Paul Mackerras <paulus@samba.org>
To: Joel Schopp <jschopp@austin.ibm.com>
In-Reply-To: <42F79D89.3040709@austin.ibm.com>
References: <17136.13558.773102.465379@cargo.ozlabs.ibm.com>
	<42F79D89.3040709@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: Merging ppc32 and ppc64
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Joel Schopp writes:

> There are several userspace applications that parse the non-flat device 
> tree in /proc/device-tree on pSeries.  While I like the idea of the 
> flattened device tree I think we need to consider how many apps we are 
> going to break with it.

... and standardizing on the flattened device tree will mean that
every ppc and ppc64 platform has stuff in /proc/device-tree, not just
those that have OF. :)

Paul.
