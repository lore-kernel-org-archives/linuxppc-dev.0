Message-Id: <200005121840.OAA25282@mal-ach.watson.ibm.com>
To: David Weis <djweis@plconline.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: some booting help 
In-Reply-To: Message from David Weis <djweis@plconline.com>
   of "Fri, 12 May 2000 13:34:56 CDT." <Pine.LNX.4.10.10005121331400.13573-100000@catbert.desm.plconline.com>
Date: Fri, 12 May 2000 14:40:24 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	I believe that AIX attaches and detaches from the I/O spaces for
every access.  It may try to cache values in one or more segment
registers, but not required that it be mapped continually -- if I remember
correctly.

David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
