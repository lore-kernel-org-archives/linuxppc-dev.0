From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: michael.fenske@arcormail.de, Michael Fenske <michael.fenske@arcormail.de>,
        Paul Mackerras <paulus@linuxcare.com>
Subject: Re: Kernel debugging??
Date: Thu, 18 Nov 1999 13:34:51 -0500
Content-Type: text/plain
Cc: linuxppc-dev@lists.linuxppc.org
References: <Pine.LNX.4.05.9911172207200.25661-100000@callisto.of.borg> <99111813390003.04211@argo.linuxcare.com.au> <38343836.9C6EE509@arcormail.de>
In-Reply-To: <38343836.9C6EE509@arcormail.de>
MIME-Version: 1.0
Message-Id: <99111813382301.00618@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> Is there something wrong with linuxcare.com.au ? If I do

>   receiving file list ... done
>   ./
>   COPYING
>   deflate on token returned -2 (700 bytes left)
>   unexpected EOF in read_timeout

I got the same thing.  Just drop the compression (the z) and see if that helps.
 It did for me.

By the way, I updated from the samba site after the linuxcare site went up (I
didn't know about the linuxcare site).  To get a good source tree I had to do
the following:

-arv --delete

The -u update kept thinking my samba version was newer than the linuxcare
version and wouldn't get the new version and there were lots of files that
needed to be deleted.


So the following worked for me

 rsync -arv --delete linuxcare.com.au::linux-pmac-stable .

I hope this helps.

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
