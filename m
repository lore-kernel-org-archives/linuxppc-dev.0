Date: Tue, 17 Dec 2002 15:09:09 +1100
From: Erik Christiansen <erik@dd.nec.com.au>
To: Jin Cheng <jcheng@redswitch.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Compiling ucd-snmp using ELDK for PPC
Message-ID: <20021217040909.GA694@dd.nec.com.au>
Reply-To: linuxppc-embedded@lists.linuxppc.org
References: <3DFA33AE.A1F2C35D@redswitch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3DFA33AE.A1F2C35D@redswitch.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Dec 13, 2002 at 11:23:26AM -0800, Jin Cheng wrote:
> I have compiled one, but only can snmpget/snmpwalk/etc, but can not
> snmpset, it always returns timeout.


   Presumably you have looked in /var/log/snmpd.log , to see what it is
telling you about the problem.

   Chances are that your access control is not right. Have you tried
everything in the FAQs on http://www.net-snmp.org/  ??

   You might like to try the mailing list (ucd-snmp was renamed net-snmp
some time ago):

List-Id:             General discussion forum for net-snmp users
List-Subscribe:      net-snmp-users-request@lists.sourceforge.net
                     subject=subscribe
List-Post:           net-snmp-users@lists.sourceforge.net

Searchable Archive:  http://sourceforge.net/mailarchive/forum.php?forum_id=4959

   The archive will give you plenty of things to check. That list will
be better equipped to advise.

Regards,
Erik


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
