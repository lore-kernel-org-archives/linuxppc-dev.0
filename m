In-Reply-To: <38343836.9C6EE509@arcormail.de>
Date: Thu, 18 Nov 1999 19:30:16 +0100
To: michael.fenske@arcormail.de, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Kernel debugging??
Message-Id: <19991118193016.014231@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Nov 18, 1999, Michael Fenske <michael.fenske@arcormail.de> wrote:

>Is there something wrong with linuxcare.com.au ? If I do
>
> rsync -arvz linuxcare.com.au::linux-pmac-stable .
>
>I get this:
>
>  Welcome to the Linuxcare Australia rsync server
>  For information about Linuxcare see http://linuxcare.com.au/
>
>
>  receiving file list ... done
>  ./
>  COPYING
>  deflate on token returned -2 (700 bytes left)
>  unexpected EOF in read_timeout
>
>rsync from samba.anu.edu.au works just fine.

I had the same problem today. Just remove the "z" option, it will eat
more bandidth but it works. I beleive it's time to update my rsync or zlib...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
