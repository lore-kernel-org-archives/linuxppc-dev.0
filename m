From: Paul Mackerras <paulus@linuxcare.com>
To: Linux/PPC Developer list <linuxppc-dev@lists.linuxppc.org>
Subject: adb_buttons kernel argument
Date: Wed, 29 Mar 2000 11:37:21 +1000
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <00032911415300.05568@argo.linuxcare.com.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have just realized that with 2.3.xx (since 2.3.18) the format of the
arguments for the adb_buttons=xxx kernel command-line argument has
changed.  With 2.2 you can say adb_buttons=1 to emulate buttons 2 and 3
with the right control and option keys, or you can say adb_buttons=xx,yy
to use keycodes xx and yy to emulate buttons 2 and 3.  With 2.3 you now
have to say adb_buttons=1,xx,yy.

I propose to change 2.3 back to the 2.2 behaviour since that is what is
documented.  Does anybody have any problem with that?

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
