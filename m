Message-Id: <199912290015.TAA24316@mal-ach.watson.ibm.com>
To: Tony Mantler <eek@escape.ca>
cc: Daniel Jacobowitz <drow@false.org>, linuxppc-dev@lists.linuxppc.org,
        libc-alpha@sourceware.cygnus.com
Subject: Re: DB_THREAD support in Berkeley DB/glibc 
In-Reply-To: Message from Tony Mantler <eek@escape.ca>
   of "Tue, 28 Dec 1999 17:21:36 CST." <v04003a01b48ef374578e@[216.81.17.184]>
Date: Tue, 28 Dec 1999 19:15:59 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	If you only are using the TSL_UNSET in the context that one
already has the lock, then the lwarx/stwcx are unnecessary.  What you have
written, however, is not a general atomic clear macro.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
