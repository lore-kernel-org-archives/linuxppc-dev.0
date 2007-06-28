Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18051.22185.374607.755419@cargo.ozlabs.ibm.com>
Date: Thu, 28 Jun 2007 16:35:21 +1000
From: Paul Mackerras <paulus@samba.org>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: for-2.6.23 branch in powerpc.git created
In-Reply-To: <Pine.LNX.4.60.0706151915580.5979@poirot.grange>
References: <18034.6787.951861.623265@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.60.0706151915580.5979@poirot.grange>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Guennadi Liakhovetski writes:

> These two i2c patches:
> 
> http://ozlabs.org/pipermail/linuxppc-dev/2007-June/037327.html
> http://ozlabs.org/pipermail/linuxppc-dev/2007-June/037328.html
> 
> also would be nice to get in, although, they only make sense with an ack 
> from Scott Wood and another patch from him, as explained in links above...

Looks OK, but the first of those two patches doesn't have a
Signed-off-by: line, and the description is not suitable.

Please repost that patch with a nice description that describes what
the patch does and why, without references to other web pages.  You
don't need to describe what is different from previous patches or who
suggested those changes.

Paul.
