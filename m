Return-Path: <anton@ozlabs.org>
Date: Tue, 4 Jan 2005 14:16:25 +1100
From: Anton Blanchard <anton@samba.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Message-ID: <20050104031625.GD7335@krispykreme.ozlabs.ibm.com>
References: <41D9CD19.50207@nortelnetworks.com>
	<20050103225822.GC7335@krispykreme.ozlabs.ibm.com>
	<41D9D6A2.2010705@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <41D9D6A2.2010705@nortelnetworks.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: dcbz not used on ppc64?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 
> Hmm.  As of 2.6.9 at least, clear_page() is only ever called by 
> clear_user_page(), which in turn is only ever called by 
> drivers/media/video/video-buf.c.  I'm not using that driver, which 
> explains why the instruction didn't show up when I disassembled the kernel.

Dont forget mm/memory.c:clear_user_highpage -> clear_user_page. 

Anton
