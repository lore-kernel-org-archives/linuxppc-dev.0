Message-ID: <376D4EDC.4983826B@americasm01.nt.com>
Date: Sun, 20 Jun 1999 16:28:12 -0400
From: "Jerry Quinn" <jquinn@nortelnetworks.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: ppp compression module aliases?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have a question that I'm not sure is best directed to kernel people or
user-space people as it crosses the line.

After a bunch of time trying to figure out why the ppp compression
modules weren't getting loaded automatically, I traced it the fact that
the appropriate aliases are not present in /etc/conf.modules.

In particular, the following aliases are required:

ppp-compress-21	= bsd-compress
ppp-compress-24 = ppp-deflate
ppp-compress-26 = ppp-deflate

I vaguely remember seeing this advice once in the past which I promptly
forgot.  So now I'd like to save others the headache and make sure this
get set up right.

The current situation is as follows: 

* modprobe 2.1.121 (which is apparently still the current version for R5
as of may 23 - I haven't reupdated) doesn't know these aliases

* The PPP HOWTO and FAQ don't mention these aliases

* The NET3 HOWTO doesn't mention these aliases

* The R4 and R5 installation don't seem to create these aliases ( If I'm
wrong about this and my install is broken, please let me know :-)

I figured this out by browsing the kernel sources ( not a bad activity,
but this info should also be elsewhere :-).

So I guess what I'm asking is if this should be in the kernel
documentation somewhere, some other documentation, or somewhere else. 
Or all of the above.

Or am I just misconfigured?

Thanks,


-- 
Jerry Quinn                             Tel: (514) 761-8737
jquinn@nortelnetworks.com               Fax: (514) 761-8505
Speech Recognition Research

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
