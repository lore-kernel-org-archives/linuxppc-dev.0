Message-ID: <373B4B42.D315FF4C@wanadoo.fr>
Date: Thu, 13 May 1999 23:59:30 +0200
From: Martin Costabel <costabel@wanadoo.fr>
Reply-To: costabel@wanadoo.fr
MIME-Version: 1.0
To: Sriranga Veeraraghavan <ranga@CSUA.Berkeley.EDU>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: cvs kernel does not compile
References: <199905131906.MAA17049@soda.CSUA.Berkeley.EDU>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Sriranga Veeraraghavan wrote:
> 
> > Well.  2.3.0 is 2.2.8.  2.3.1-pre2 (in CVS now) is not. :)
> 
> This may be a stupid question, but what is the best site to download
> the latest version of the kernel with the current PPC/PMac fixes?
> 
> I haven't had very good luck with the kernel src on linuxhq.com.

If you are on cvs from openprojects, you can get a 2.3.0 kernel via
 cvs -z3 update -D "5/12/99 10:00:00"
This is more or less the latest one that actually compiles.

But since the linuxppc developers release 1.0 is out now, the 2.2.6-15a
kernel sources that come with it will probably remain a stable reference
for some time to come.

--
Martin

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
