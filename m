Message-Id: <200008091516.LAA14188@mal-ach.watson.ibm.com>
To: Edwin Tam <edwintam@ieee.org>
cc: mpeters@omnilinux.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: php compilation fix 
In-Reply-To: Message from Edwin Tam <edwintam@ieee.org>
   of "Wed, 09 Aug 2000 13:45:57 +0800." <B5B71115.316A%edwintam@ieee.org>
Date: Wed, 09 Aug 2000 11:16:55 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Are you sure that va_copy() does not work?  That clearly was the
*intent* of the person who wrote the broken code and va_copy() should work
correctly on PowerPC SVR4 ABI for Linux.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
