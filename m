Reply-To: <zjzhou@newrocktech.com>
From: "John Zhou" <zjzhou@newrocktech.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: display top CPU processes top tool
Date: Fri, 5 Sep 2003 16:26:02 +0800
Message-ID: <000001c37387$5897abe0$9702a8c0@newrock2>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <3F574F48.9040704@kegel.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, all

I'm using "top" tool to display top CPU processes and system running information in my Embedded Linux based on PowerPC. But, when I run "top" command in prompt #, it's coming on:

# set
PS2=>
PS1=#
IFS=
USER=root
SHELL=/bin/sh
PATH=/usr/bin:/bin:/usr/sbin:/sbin
HOME=/
TERM=ansi
#
# top
top: Unknown terminal "ansi" in $TERM
#

I changed to :

# export TERM=VT100
# set
PS2=>
PS1=#
IFS=
USER=root
SHELL=/bin/sh
PATH=/usr/bin:/bin:/usr/sbin:/sbin
HOME=/
TERM=VT100
# top
top: Unknown terminal "VT100" in $TERM
#

Another question:

How to use "top" with option to save cpu information to a log file?

Thanks for any help.

John Zhou

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
