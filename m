Return-Path: <noe.serres@gmail.com>
Message-ID: <f8bc181b0601030606x3b29ee28q@mail.gmail.com>
Date: Tue, 3 Jan 2006 15:06:40 +0100
From: =?ISO-8859-1?Q?No=E9_SERRES?= <noe.serres@gmail.com>
To: Linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_31048_3624195.1136297200002"
Subject: "argument list too long"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_31048_3624195.1136297200002
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I'm trying to compile a kernel for an embedded-powerpc-linux application.
As a first step/training, I followed closely the instructions of the
document "The DENX U-Boot and Linux Guide" for a TQM8XXL board, that is to
say:

bash$ mrproper
bash$ make TQM823L_config
bash$ make oldconfig
bash$ make dep

After a few minutes of dependency creation, I get the following error
"argument list too long":

scripts/mkdep -- `find
/usr/src/linuxppc_2_4_devel-2005-10-25-1440/include/asm
/usr/src/linuxppc_2_4
_devel-2005-10-25-1440/include/linux
/usr/src/linuxppc_2_4_devel-2005-10-25-1440/include/scsi /usr/s
rc/linuxppc_2_4_devel-2005-10-25-1440/include/net
/usr/src/linuxppc_2_4_devel-2005-10-25-1440/includ
e/math-emu \( -name SCCS -o -name .svn \) -prune -o -follow -name \*.h !
-name modversions.h -print`
 > .hdepend
scripts/mkdep: argument list too long
make: *** [dep-files] Error 2

Can someone help me understand where that comes from?
Does it have something to do with the fact that I work under WinXP + Cygwin=
?
No need to say that I am a newbie to the Linux world... help me, Wolfgang
:-)

Noe Serres
Midi Ingenierie
Toulouse (FR)

------=_Part_31048_3624195.1136297200002
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br>
<br>
I'm trying to compile a kernel for an embedded-powerpc-linux application.<b=
r>
As a first step/training, I followed closely the instructions of the
document &quot;The DENX U-Boot and Linux Guide&quot; for a TQM8XXL board, t=
hat is
to say:<br>
<br>
bash$ mrproper<br>
bash$ make TQM823L_config<br>
bash$ make oldconfig<br>
bash$ make dep<br>
<br>
After a few minutes of dependency creation, I get the following error &quot=
;argument list too long&quot;:<br>
<br>
scripts/mkdep -- `find /usr/src/linuxppc_2_4_devel-2005-10-25-1440/include/=
asm /usr/src/linuxppc_2_4<br>
_devel-2005-10-25-1440/include/linux /usr/src/linuxppc_2_4_devel-2005-10-25=
-1440/include/scsi /usr/s<br>
rc/linuxppc_2_4_devel-2005-10-25-1440/include/net /usr/src/linuxppc_2_4_dev=
el-2005-10-25-1440/includ<br>
e/math-emu \( -name SCCS -o -name .svn \) -prune -o -follow -name \*.h ! -n=
ame modversions.h -print`<br>
&nbsp;&gt; .hdepend<br>
scripts/mkdep: argument list too long<br>
make: *** [dep-files] Error 2<br>
<br>
Can someone help me understand where that comes from?<br>
Does it have something to do with the fact that I work under WinXP + Cygwin=
?<br>
No need to say that I am a newbie to the Linux world... help me, Wolfgang :=
-)<br>
<br>
Noe Serres<br>
Midi Ingenierie<br>
Toulouse (FR)

------=_Part_31048_3624195.1136297200002--
