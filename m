Message-ID: <3850F28A.D36731A3@eng.uct.ac.za>
Date: Fri, 10 Dec 1999 14:31:06 +0200
From: Grant Carter <gcarter@eng.uct.ac.za>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Kernel woes for versions > 2.2.5
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all

I have successfully compiled the 2.2.5 kernel which is found on the ftp
site for my BSE-IP board. Now that that seems to work, I would like to
get a newer version of the kernel working. I have tried unsucessfully
with both the 2.3.18 kernel on the CVS server and the tarball of it that
Dan put up for ftp. The problem is that after the kernel has been loaded
into RAM at address 200000 and told to execute from address 210000, the
processor just hangs with no output on the console. It doesn't even get
to the "Linux/PPC load:" prompt. The process I just described was what I
was told to do for 2.2.5 and it works just great. Is there a different
method for the other kernel versions? Any ideas on where to go from
here?

Many thanks in advance,
Grant

-- 
Grant Carter                              gcarter@eng.uct.ac.za
Department of Electrical Engineering      University of Cape Town
Tel: +27 (0)21 650-3467                   Fax: +27 (0)21 650-3465
                     "Coffee not found - operator halted!"

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
