Message-Id: <9911180426.AA27310@marc.watson.ibm.com>
To: "David N. Welton" <davidw@linuxcare.com>
Cc: Linux -Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: again 2.3.28 
In-Reply-To: Message from "David N. Welton" <davidw@linuxcare.com>
   of "Wed, 17 Nov 1999 20:03:00 PST." <19991117200300.B4647@bassano.linuxcare.com>
Date: Wed, 17 Nov 1999 23:26:39 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	You're just messing with something.  Most likely you are
disrupting the condition register bits being used by the "blt" branch.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
