Message-Id: <200103010411.XAA21536@mal-ach.watson.ibm.com>
To: "kerler" <kerler@mailandnews.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: dynamic modification exception handler 
In-Reply-To: Message from "kerler" <kerler@mailandnews.com>
   of "Thu, 01 Mar 2001 11:49:06 +0800." <002c01c0a202$ed6ecdb0$5ef1d092@chn.agilent.com>
Date: Wed, 28 Feb 2001 23:11:56 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Note that the cache block size is implementation-dependent and not
specified by the PowerPC architecture.  The 32-bit 6xx and derived
processors have that cache block size, but not embedded processors and not
high-end 64-bit PowerPC processors.  So just be aware that you code is not
portable.

David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
