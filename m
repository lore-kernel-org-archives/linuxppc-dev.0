From: Paul Mackerras <paulus@linuxcare.com>
To: linuxppc-dev@lists.linuxppc.org, Eric Benard <ebenard@ifrance.com>
Subject: Re: 2.3.43 failed
Date: Sun, 13 Feb 2000 18:29:10 +1100
Content-Type: text/plain
References: <00021211003504.00821@linux.eric.fr>
MIME-Version: 1.0
Message-Id: <00021318311301.12422@argo.linuxcare.com.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 12 Feb 2000, Eric Benard wrote:

> it compiles fine on a B&W G3 but doesn't run : it stops after the "Booting..."
> message.

I just updated linuxcare.com.au::linux-pmac-devel to 2.3.44 final.  I
fixed a couple of problems where it would hang during boot if you booted
from OF (or with quik or yaboot) and it couldn't find the screen.  Try it
now.  If it doesn't work, let me know (and tell me how you are booting it).

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
