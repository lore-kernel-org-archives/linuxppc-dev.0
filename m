Message-ID: <3FD41F48.3030000@kegel.com>
Date: Sun, 07 Dec 2003 22:50:48 -0800
From: Dan Kegel <dank@kegel.com>
MIME-Version: 1.0
To: zjzhou@newrocktech.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Which program can re-launch my application when this application
 exit for exception?
References: <000801c3bd55$5a1dd440$b702a8c0@newrock2>
In-Reply-To: <000801c3bd55$5a1dd440$b702a8c0@newrock2>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


John Zhou wrote:
> Which program can re-launch my application when this application exit for exception or error?

Your own.  It's pretty easy to write a shell script to do this.
Or you can use initd to do the same thing; see 'man inittab'.

Your questions seem to be fairly generic, not related to
the ppc; you might want to try asking
this kind of question on, say,
http://groups.google.com/groups?group=comp.os.linux.embedded
or http://www.embeddedtux.org/pipermail/etux/
- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
