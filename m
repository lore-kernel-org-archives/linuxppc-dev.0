Message-ID: <20030919192939.31485.qmail@web40412.mail.yahoo.com>
Date: Fri, 19 Sep 2003 12:29:39 -0700 (PDT)
From: Todd <to_dd@yahoo.com>
Subject: exernalizing module functions to user space
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I would like to make certain functions in my driver
available to user space applications.  At first it
seemed that EXTERN_SYMBOL was the solution, but this
appears to externalize the functions only to other
modules.
I considered adding specialized entries in the
file_operations structure...but this does not seem
appropriate.  Can anyone explain the proper method of
acheiving this??

TIA
-Todd


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
