Date: Wed, 17 Mar 2004 11:19:53 -0600
From: Josh Rosenau <jrosenau@ku.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: [LPPC] Random crashes on snooze
Message-ID: <20040317171953.GB3195@ku.edu>
Reply-To: jrosenau@ku.edu
References: <20040316230925.15bfe069.iweiny@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040316230925.15bfe069.iweiny@acm.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


So on Tue, Mar 16, 2004 at 11:09:25PM -0800, Ira Weiny was all like,

>I put some debug messages in the sleep code and I think it might have something
>to do with the awacs sound driver.
>
>>From /var/log/messages on a bad sleep:
>
>Mar 16 17:49:15 batwing2 kernel: IKW sleep 1 calling c03b5ff4 (c020cae0)
>Mar 16 17:49:15 batwing2 kernel: aty128fb: aty128_sleep_notify when 1 board c1ab1800
>Mar 16 17:49:16 batwing2 kernel: IKW sleep 1 accepted by c03b5ff4 (c020cae0)
>Mar 16 17:49:16 batwing2 kernel: IKW Sync disks
>Mar 16 17:49:16 batwing2 kernel: IKW sleep 2 calling c03868ec (c01d1b6c)
>Dec 31 20:53:02 batwing2 syslogd 1.4.1: restart.
>
>>From System.map
>c01d1b6c t awacs_sleep_notify
>
>But I don't know if there is something missing from the file because of course
>nothing can be written to the disk at this time...  Does anyone have any other
>clues?

I've avoided crashes on sleep on my Lombard by always unloading the
sound module.  It isn't elegant, but it works.  One more data point.


--
Joshua Rosenau                         1345 Jayhawk Boulevard/Dyche Hall
(785) 864-4159                                   Lawrence, KS 66045-7561
         The struggling for knowledge has a pleasure in it like
          that of wrestling with a fine woman. -- Lord Halifax

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
