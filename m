Message-ID: <38343836.9C6EE509@arcormail.de>
Date: Thu, 18 Nov 1999 18:32:40 +0100
From: Michael Fenske <michael.fenske@arcormail.de>
Reply-To: michael.fenske@arcormail.de
MIME-Version: 1.0
To: Paul Mackerras <paulus@linuxcare.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel debugging??
References: <Pine.LNX.4.05.9911172207200.25661-100000@callisto.of.borg> <99111813390003.04211@argo.linuxcare.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:

> is old, maybe I should just remove it.  I will be putting stuff on
> linuxcare.com.au (== ftp.linuxcare.com.au) generally from now on.

Is there something wrong with linuxcare.com.au ? If I do

 rsync -arvz linuxcare.com.au::linux-pmac-stable .

I get this:

  Welcome to the Linuxcare Australia rsync server
  For information about Linuxcare see http://linuxcare.com.au/


  receiving file list ... done
  ./
  COPYING
  deflate on token returned -2 (700 bytes left)
  unexpected EOF in read_timeout

rsync from samba.anu.edu.au works just fine.

Michael

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
