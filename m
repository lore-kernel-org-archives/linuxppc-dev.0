Return-Path: <m_dalmas@yahoo.com.br>
Received: from n8.bullet.re3.yahoo.com (n8.bullet.re3.yahoo.com
	[68.142.237.93])
	by bilbo.ozlabs.org (Postfix) with SMTP id 22E39B70B4
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  6 Jun 2009 07:02:02 +1000 (EST)
Message-ID: <300510.25179.qm@web111311.mail.gq1.yahoo.com>
Date: Fri, 5 Jun 2009 14:01:56 -0700 (PDT)
From: Marcelo Dalmas <m_dalmas@yahoo.com.br>
Subject: Add "mpc5200-simple-platform" to the list of supported boards
To: linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1966828119-1244235716=:25179"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--0-1966828119-1244235716=:25179
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,=0A=0AAdding  "mpc5200-simple-platform" to the list of supported boar=
ds allow to use the option "Generic support for simple MPC5200 based boards=
" without patching the kernel. Just set model to "mpc5200-simple-plataform"=
 on your dts file.=0A=0A=0A      Veja quais s=E3o os assuntos do momento no=
 Yahoo! +Buscados=0Ahttp://br.maisbuscados.yahoo.com
--0-1966828119-1244235716=:25179
Content-Type: text/x-diff; name="add_mpc5200_simple_platform_to_supported_boards.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="add_mpc5200_simple_platform_to_supported_boards.patch"

ZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvNTJ4eC9tcGM1
MjAwX3NpbXBsZS5jIGIvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy81Mnh4L21w
YzUyMDBfc2ltcGxlLmMKaW5kZXggYzMxZTViNS4uYTJkZjc5NSAxMDA2NDQK
LS0tIGEvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy81Mnh4L21wYzUyMDBfc2lt
cGxlLmMKKysrIGIvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy81Mnh4L21wYzUy
MDBfc2ltcGxlLmMKQEAgLTUwLDYgKzUwLDcgQEAgc3RhdGljIHZvaWQgX19p
bml0IG1wYzUyMDBfc2ltcGxlX3NldHVwX2FyY2godm9pZCkKIAogLyogbGlz
dCBvZiB0aGUgc3VwcG9ydGVkIGJvYXJkcyAqLwogc3RhdGljIGNoYXIgKmJv
YXJkW10gX19pbml0ZGF0YSA9IHsKKwkibXBjNTIwMC1zaW1wbGUtcGxhdGZv
cm0iLAogCSJpbnRlcmNvbnRyb2wsZGlnc3ktbXRjIiwKIAkicGh5dGVjLHBj
bTAzMCIsCiAJInBoeXRlYyxwY20wMzIiLAo=

--0-1966828119-1244235716=:25179--
