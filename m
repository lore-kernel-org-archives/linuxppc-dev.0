Date: Fri, 12 May 2000 13:50:43 -0500 (CDT)
From: David Weis <djweis@plconline.com>
To: David Edelsohn <dje@watson.ibm.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: some booting help 
In-Reply-To: <200005121840.OAA25282@mal-ach.watson.ibm.com>
Message-ID: <Pine.LNX.4.10.10005121349370.13573-100000@catbert.desm.plconline.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 12 May 2000, David Edelsohn wrote:
> 	I believe that AIX attaches and detaches from the I/O spaces for
> every access.  It may try to cache values in one or more segment
> registers, but not required that it be mapped continually -- if I remember
> correctly.

I was looking at the BUSIO_ATT and BUSIO_DET functions in
/usr/include/sys/adspace.h for clues. I had downloaded some AIX driver
source code examples once but can't seem to find them any more.

Thanks

dave


--
David Weis                | 10520 New York Ave, Des Moines, IA 50322
djweis@plconline.com      | Voice 515-278-0133 Ext 231
                          | http://www.perfectionlearning.com/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
