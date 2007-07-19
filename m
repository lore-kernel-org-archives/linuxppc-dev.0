Return-Path: <scottwood@freescale.com>
Message-ID: <469FB47D.4030009@freescale.com>
Date: Thu, 19 Jul 2007 13:59:09 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/4] mpc8349emitx: Add chosen node for default stdout path
References: <20070719183415.7458.42622.stgit@trillian>
	<20070719183734.7458.83695.stgit@trillian>
In-Reply-To: <20070719183734.7458.83695.stgit@trillian>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> To boot from a cuImage requires the device tree to have a
> linux,stdout-path property in the chosen node.  This patch adds it
> to the .dts files.

This will break many current u-boots, as they blindly add a /chosen node 
regardless of whether one already exists.

-Scott
