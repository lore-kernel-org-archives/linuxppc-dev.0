Message-Id: <200311152259.hAFMxGT27464@makai.watson.ibm.com>
To: Olaf Hering <olh@suse.de>
Cc: Alan Modra <amodra@bigpond.net.au>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: kernel oops due to unaligned access with lswi 
In-Reply-To: Message from Olaf Hering <olh@suse.de>
   of "Sat, 15 Nov 2003 23:43:42 +0100." <20031115224342.GA16897@suse.de>
References: <20031115210449.GA10105@suse.de> <20031115222430.GA13820@suse.de> <200311152230.hAFMUwT32990@makai.watson.ibm.com>  <20031115224342.GA16897@suse.de> 
Date: Sat, 15 Nov 2003 17:59:16 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	I didn't mean that lswi cannot take an alignment exception on some
PPC implementations, but that lswi is suppose to be able to handle block
loads from addresses with arbitrary alignment.

David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
